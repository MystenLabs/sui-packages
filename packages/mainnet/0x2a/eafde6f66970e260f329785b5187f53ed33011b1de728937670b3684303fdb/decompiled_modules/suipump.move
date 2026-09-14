module 0x2aeafde6f66970e260f329785b5187f53ed33011b1de728937670b3684303fdb::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044341505907436170795375699601436170797061726120537569206973206120636f6d6d756e6974792d64726976656e206d656d652070726f6a65637420696e73706972656420627920746865206368696c6c65737420616e696d616c206f6e2074686520706c616e657420e280942074686520436170796261726120e2809420616e642074686520666173742d67726f77696e67205375692065636f73797374656d2e5368747470733a2f2f7777772e636c69706172746d61782e636f6d2f706e672f66756c6c2f3333372d333337363338335f6265617665722d706e672d66696c652d63617079626172612d766563746f722e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

