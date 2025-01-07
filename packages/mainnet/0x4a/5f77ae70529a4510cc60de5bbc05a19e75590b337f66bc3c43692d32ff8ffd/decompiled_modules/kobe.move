module 0x4a5f77ae70529a4510cc60de5bbc05a19e75590b337f66bc3c43692d32ff8ffd::kobe {
    struct KOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBE>(arg0, 6, b"KOBE", b"BALLER", b"The Black Mamba!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7594_bbd44e90ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

