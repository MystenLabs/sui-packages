module 0xefcd6853886dfeb9022050dba822ba1c6fc695552996770dfdc48c455a6b5b0a::cupank {
    struct CUPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPANK>(arg0, 6, b"CUPANK", b"SUI CUPANK", b"True King of The Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_f6825f5ecf.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUPANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

