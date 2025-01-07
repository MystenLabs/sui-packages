module 0x89a3caf3ea2357bf282d3cae1d9da50319c20891ce5fe5cf243fdb56b1030ccd::ironyman {
    struct IRONYMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONYMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRONYMAN>(arg0, 6, b"Ironyman", b"Irony Man", b"Elon Musk new meme, let's welcome IRONYMAN !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732419329452.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRONYMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRONYMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

