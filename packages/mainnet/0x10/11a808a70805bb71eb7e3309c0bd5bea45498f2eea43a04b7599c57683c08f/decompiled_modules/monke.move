module 0x1011a808a70805bb71eb7e3309c0bd5bea45498f2eea43a04b7599c57683c08f::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"MONKE", b"Monke", b"Big brain? Nah. Big gains? YUP.  MONKE isnt here to think, its here to vibe, swing, and take over the meme jungle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9k_Wt_a_Of_400x400_removebg_preview_041a071888.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

