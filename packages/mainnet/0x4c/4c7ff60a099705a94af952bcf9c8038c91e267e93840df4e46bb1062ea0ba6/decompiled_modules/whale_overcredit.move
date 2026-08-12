module 0x4c4c7ff60a099705a94af952bcf9c8038c91e267e93840df4e46bb1062ea0ba6::whale_overcredit {
    struct HeldSupply<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    struct TokenTransferAlreadyClaimed has copy, drop {
        source_chain: u8,
        message_type: u8,
        bridge_seq_num: u64,
        labeled_for: address,
        claimed_amount: u64,
    }

    struct FatObject has store, key {
        id: 0x2::object::UID,
        blob: vector<u8>,
        labeled_for: address,
    }

    struct FatObjectCreated has copy, drop {
        object_id: address,
        labeled_for: address,
        blob_len: u64,
    }

    public entry fun claim_success_zero(arg0: bool, arg1: u8, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0) {
            let v0 = TokenTransferAlreadyClaimed{
                source_chain   : arg1,
                message_type   : arg2,
                bridge_seq_num : arg3,
                labeled_for    : arg4,
                claimed_amount : arg5,
            };
            0x2::event::emit<TokenTransferAlreadyClaimed>(v0);
        };
    }

    public fun create_fat_object(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 65);
            v1 = v1 + 1;
        };
        let v2 = FatObject{
            id          : 0x2::object::new(arg2),
            blob        : v0,
            labeled_for : arg1,
        };
        let v3 = FatObjectCreated{
            object_id   : 0x2::object::id_address<FatObject>(&v2),
            labeled_for : arg1,
            blob_len    : arg0,
        };
        0x2::event::emit<FatObjectCreated>(v3);
        0x2::transfer::public_transfer<FatObject>(v2, arg1);
    }

    public fun destroy_fat_object(arg0: FatObject) {
        let FatObject {
            id          : v0,
            blob        : v1,
            labeled_for : _,
        } = arg0;
        let v3 = v1;
        0x1::vector::length<u8>(&v3);
        0x2::object::delete(v0);
    }

    public fun mint_string_and_send(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::create_supply<0x1::string::String>(0x1::string::utf8(b"whale"));
        0x2::balance::send_funds<0x1::string::String>(0x2::balance::increase_supply<0x1::string::String>(&mut v0, arg0), arg1);
        let v1 = HeldSupply<0x1::string::String>{
            id     : 0x2::object::new(arg2),
            supply : v0,
        };
        0x2::transfer::public_transfer<HeldSupply<0x1::string::String>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun mint_u64_and_send(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::create_supply<u64>(0);
        0x2::balance::send_funds<u64>(0x2::balance::increase_supply<u64>(&mut v0, arg0), arg1);
        let v1 = HeldSupply<u64>{
            id     : 0x2::object::new(arg2),
            supply : v0,
        };
        0x2::transfer::public_transfer<HeldSupply<u64>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun mint_url_and_send(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::create_supply<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://whale.invalid/fake"));
        0x2::balance::send_funds<0x2::url::Url>(0x2::balance::increase_supply<0x2::url::Url>(&mut v0, arg0), arg1);
        let v1 = HeldSupply<0x2::url::Url>{
            id     : 0x2::object::new(arg2),
            supply : v0,
        };
        0x2::transfer::public_transfer<HeldSupply<0x2::url::Url>>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

