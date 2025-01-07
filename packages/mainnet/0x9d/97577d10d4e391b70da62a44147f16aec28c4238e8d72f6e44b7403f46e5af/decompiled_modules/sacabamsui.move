module 0x9d97577d10d4e391b70da62a44147f16aec28c4238e8d72f6e44b7403f46e5af::sacabamsui {
    struct SACABAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SACABAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SACABAMSUI>(arg0, 6, b"SACABAMSUI", b"SACABAM", b"Sacabam - $SACABAMSUI is native meme on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_205720894_827a733b6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SACABAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SACABAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

