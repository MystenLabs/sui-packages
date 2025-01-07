module 0x7d340024f3cf08bee7faed4307595676cbd27e9967f1e612314d304718d59789::dogex {
    struct DOGEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEX>(arg0, 6, b"DOGEX", b"DogeX", x"446f6765582066696e616c6c79206f6e20245355490a50756d702069742075702121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3677_1679156ed8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

