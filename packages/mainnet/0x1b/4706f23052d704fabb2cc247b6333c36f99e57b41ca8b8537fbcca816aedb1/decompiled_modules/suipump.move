module 0x1b4706f23052d704fabb2cc247b6333c36f99e57b41ca8b8537fbcca816aedb1::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034c4951064c6971756f72774c6971756f7220697320612077696e65206d656d652070726f6a656374207468617420686f70657320746f206272696e672068756765206c697175696469747920616e642066756e20746f20746865205375692065636f73797374656d20616e64206275696c642061206d656d652063756c747572652e6268747470733a2f2f696d672e62677374617469632e636f6d2f6d756c74694c616e672f696d6167652f736f6369616c2f3039323337666332323631336234393365663535623663353365336235393562313732383338363535343431362e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

