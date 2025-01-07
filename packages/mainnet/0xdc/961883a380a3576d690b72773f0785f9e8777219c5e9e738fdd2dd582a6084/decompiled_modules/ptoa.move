module 0xdc961883a380a3576d690b72773f0785f9e8777219c5e9e738fdd2dd582a6084::ptoa {
    struct PTOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOA>(arg0, 6, b"PTOA", b"Pweter Toad", b"Meet Da mysterious foundwer of $BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9f_W_Xpgd3_400x400_529d9562eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

