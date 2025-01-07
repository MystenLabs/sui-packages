module 0x34264e0fb9c5a3051ebd881e45811e06bb91146990091b847a3992f6a1413ba6::chnk {
    struct CHNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHNK>(arg0, 6, b"CHNK", b"CHONKERS", b"Based off a cat named Milo his favorite activities are sleeping, eating and GOING TO THE MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chonk_8be1d86ae7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

