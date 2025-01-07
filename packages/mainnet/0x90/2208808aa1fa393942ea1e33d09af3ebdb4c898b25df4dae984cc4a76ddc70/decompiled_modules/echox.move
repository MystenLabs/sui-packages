module 0x902208808aa1fa393942ea1e33d09af3ebdb4c898b25df4dae984cc4a76ddc70::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 6, b"ECHOX", b"EchoXRunner", x"274563686f5852756e6e65723a20f09f8eae20436f6d6d616e6420616374696f6e207769746820796f757220766f69636520696e207468697320746872696c6c696e6720334420706c6174666f726d65722c207365616d6c6573736c7920626c656e64696e672077697468205765623320746563686e6f6c6f67792e200af09f9a8020456d627261636520746865206675747572652122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736102830989.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

