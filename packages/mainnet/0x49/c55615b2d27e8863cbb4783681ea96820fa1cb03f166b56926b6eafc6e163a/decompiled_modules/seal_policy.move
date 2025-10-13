module 0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_policy {
    struct MagazineOwner has key {
        id: 0x2::object::UID,
        allowlist: vector<0x2::object::ID>,
        magazine: vector<u8>,
    }

    struct BulletStoreOwner has key {
        id: 0x2::object::UID,
        owner: address,
        store: vector<u8>,
    }

    struct AuctionOwner has key {
        id: 0x2::object::UID,
        creator: address,
        allowlist: vector<address>,
    }

    entry fun destroy_auction_owner(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: AuctionOwner) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        let AuctionOwner {
            id        : v0,
            creator   : _,
            allowlist : _,
        } = arg2;
        0x2::object::delete(v0);
    }

    fun is_allowlisted(arg0: &MagazineOwner, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.allowlist, &arg1)
    }

    fun is_auction_allowlisted(arg0: &AuctionOwner, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.allowlist, &v0)
    }

    fun is_owner(arg0: &BulletStoreOwner, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun issue_auction_owner(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        let v0 = AuctionOwner{
            id        : 0x2::object::new(arg3),
            creator   : 0x2::tx_context::sender(arg3),
            allowlist : arg2,
        };
        0x2::transfer::share_object<AuctionOwner>(v0);
    }

    public fun issue_magazine_owner(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, MagazineOwner) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        let v0 = MagazineOwner{
            id        : 0x2::object::new(arg3),
            allowlist : arg2,
            magazine  : 0x1::vector::empty<u8>(),
        };
        (0x2::object::id<MagazineOwner>(&v0), v0)
    }

    entry fun issue_store_owner(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        let v0 = BulletStoreOwner{
            id    : 0x2::object::new(arg4),
            owner : arg2,
            store : arg3,
        };
        0x2::transfer::share_object<BulletStoreOwner>(v0);
    }

    entry fun seal_approve_auction(arg0: vector<u8>, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: &AuctionOwner, arg3: &0x2::tx_context::TxContext) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        assert!(is_auction_allowlisted(arg2, arg3), 0);
    }

    entry fun seal_approve_luca(arg0: vector<u8>, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: &BulletStoreOwner, arg3: &0x2::tx_context::TxContext) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        assert!(is_owner(arg2, 0x2::tx_context::sender(arg3)), 0);
    }

    entry fun seal_approve_magazine_info(arg0: vector<u8>, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg3: &MagazineOwner, arg4: 0x2::object::ID) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg2);
        assert!(is_allowlisted(arg3, arg4), 0);
    }

    entry fun seal_approve_magazine_info_free(arg0: vector<u8>, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg3: &MagazineOwner, arg4: 0x2::object::ID) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg2);
        assert!(is_allowlisted(arg3, arg4), 0);
    }

    public fun set_magazine(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: MagazineOwner, arg2: vector<u8>) {
        arg1.magazine = arg2;
        0x2::transfer::share_object<MagazineOwner>(arg1);
    }

    entry fun update_magazine(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &mut MagazineOwner, arg2: vector<u8>) {
        arg1.magazine = arg2;
    }

    entry fun update_store_data(arg0: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority::SealAuthorityCap, arg1: &0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::Version, arg2: &mut BulletStoreOwner, arg3: vector<u8>) {
        0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_version::validate_version(arg1);
        arg2.store = arg3;
    }

    // decompiled from Move bytecode v6
}

