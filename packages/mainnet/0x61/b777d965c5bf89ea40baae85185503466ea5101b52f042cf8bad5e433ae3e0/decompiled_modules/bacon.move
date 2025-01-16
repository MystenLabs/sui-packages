module 0x61b777d965c5bf89ea40baae85185503466ea5101b52f042cf8bad5e433ae3e0::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 6, b"BACON", b"Bacon", x"57686f20697320726561647920666f7220736f6d65206261636f6e3f0a486f772075206c696b652075727320437269707379206f72206a756963793f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_6908eeeb68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

