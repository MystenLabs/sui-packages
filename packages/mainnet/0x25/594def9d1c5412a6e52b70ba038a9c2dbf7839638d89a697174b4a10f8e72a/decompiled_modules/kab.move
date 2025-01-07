module 0x25594def9d1c5412a6e52b70ba038a9c2dbf7839638d89a697174b4a10f8e72a::kab {
    struct KAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAB>(arg0, 9, b"Kab", b"kabao3coin", x"41206e65772063727970746f6865726f2077686f20697320612063726f7373206265747765656e20612068756d616e20616e64206120686970706f2e20447265616d20686f6c696461797320636f6d652074727565210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5993b9411253bfa3e22366c560f94168blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

