module 0xca775f098180089f15f1d6e2f80488d7c68baf1b664c6f932f6d48212676295f::suifin {
    struct SUIFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFIN>(arg0, 6, b"SUIFIN", b"DIAMOND FIN", b"a simple diamond delphine on the sui block chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22548034a9a357a4fc21b8d496057d50_73fb6bac50.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

