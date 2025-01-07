module 0xa655c91fceaa805ee86ae3a60b848b8a8aa9d876ed5dd6002cc8747d54aee59e::mushlo {
    struct MUSHLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHLO>(arg0, 9, b"MUSHLO", b"WAVE", b"WAWE is a meme inspired by the spirit of adventure and freedom. With WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7f88c69-316a-4654-8347-71b07ff9a002.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSHLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

