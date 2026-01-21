module 0xf8a92aef02b5c0691f666576cce72c6eaade27b3d9316a99fc301aa08dc6fbf4::umi_container {
    struct UmiContainer has store, key {
        id: 0x2::object::UID,
        owner: address,
        cap_id: 0x2::object::ID,
        next_claim_id: u64,
        claims: vector<Claim>,
        invalidated: bool,
    }

    struct Claim has drop, store {
        id: u64,
        chain: u16,
        standard: u8,
        collection: vector<u8>,
        token_id: vector<u8>,
        metadata_uri_hint: vector<u8>,
    }

    struct ContainerCreated has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        cap_id: 0x2::object::ID,
    }

    struct CapWithdrawn has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        cap_id: 0x2::object::ID,
        removed_claims: u64,
    }

    struct ClaimAdded has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        claim_id: u64,
        chain: u16,
        standard: u8,
        collection: vector<u8>,
        token_id: vector<u8>,
        metadata_uri_hint: vector<u8>,
    }

    struct ClaimRemoved has copy, drop {
        container_id: 0x2::object::ID,
        owner: address,
        claim_id: u64,
    }

    struct UMI_CONTAINER has drop {
        dummy_field: bool,
    }

    public fun add_claim(arg0: &mut UmiContainer, arg1: u16, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg6);
        assert_owner(arg0, v0);
        let v1 = arg0.next_claim_id;
        arg0.next_claim_id = arg0.next_claim_id + 1;
        let v2 = Claim{
            id                : v1,
            chain             : arg1,
            standard          : arg2,
            collection        : arg3,
            token_id          : arg4,
            metadata_uri_hint : arg5,
        };
        0x1::vector::push_back<Claim>(&mut arg0.claims, v2);
        let v3 = ClaimAdded{
            container_id      : 0x2::object::id<UmiContainer>(arg0),
            owner             : v0,
            claim_id          : v1,
            chain             : arg1,
            standard          : arg2,
            collection        : arg3,
            token_id          : arg4,
            metadata_uri_hint : arg5,
        };
        0x2::event::emit<ClaimAdded>(v3);
        v1
    }

    fun assert_owner(arg0: &UmiContainer, arg1: address) {
        assert!(arg0.owner == arg1, 0);
        assert!(!arg0.invalidated, 1);
    }

    public fun cap_id(arg0: &UmiContainer) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun claims(arg0: &UmiContainer) : &vector<Claim> {
        &arg0.claims
    }

    public fun clear_claims(arg0: &mut UmiContainer, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.claims = 0x1::vector::empty<Claim>();
        0x1::vector::length<Claim>(&arg0.claims)
    }

    public fun create_container_with_dwallet(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>, arg7: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg8: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : (UmiContainer, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, v2) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        let v4 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v3);
        let v5 = UmiContainer{
            id            : 0x2::object::new(arg10),
            owner         : v0,
            cap_id        : v4,
            next_claim_id : 0,
            claims        : 0x1::vector::empty<Claim>(),
            invalidated   : false,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v5.id, v4, v3);
        let v6 = ContainerCreated{
            container_id : 0x2::object::id<UmiContainer>(&v5),
            owner        : v0,
            cap_id       : v4,
        };
        0x2::event::emit<ContainerCreated>(v6);
        (v5, v2)
    }

    fun init(arg0: UMI_CONTAINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Umi Container"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A cross-chain asset container powered by Umi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://server.umi.app/api/containers/image/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://umi.app/container/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://umi.app"));
        let v4 = 0x2::package::claim<UMI_CONTAINER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<UmiContainer>(&v4, v0, v2, arg1);
        0x2::display::update_version<UmiContainer>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<UmiContainer>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun invalidated(arg0: &UmiContainer) : bool {
        arg0.invalidated
    }

    public fun owner(arg0: &UmiContainer) : address {
        arg0.owner
    }

    public fun remove_claim(arg0: &mut UmiContainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner(arg0, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Claim>(&arg0.claims)) {
            if (0x1::vector::borrow<Claim>(&arg0.claims, v1).id == arg1) {
                0x1::vector::swap_remove<Claim>(&mut arg0.claims, v1);
                let v2 = ClaimRemoved{
                    container_id : 0x2::object::id<UmiContainer>(arg0),
                    owner        : v0,
                    claim_id     : arg1,
                };
                0x2::event::emit<ClaimRemoved>(v2);
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun withdraw(arg0: &mut UmiContainer, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner(arg0, v0);
        let v1 = arg0.cap_id;
        arg0.claims = 0x1::vector::empty<Claim>();
        arg0.invalidated = true;
        let v2 = CapWithdrawn{
            container_id   : 0x2::object::id<UmiContainer>(arg0),
            owner          : v0,
            cap_id         : v1,
            removed_claims : (0x1::vector::length<Claim>(&arg0.claims) as u64),
        };
        0x2::event::emit<CapWithdrawn>(v2);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v1)
    }

    // decompiled from Move bytecode v6
}

