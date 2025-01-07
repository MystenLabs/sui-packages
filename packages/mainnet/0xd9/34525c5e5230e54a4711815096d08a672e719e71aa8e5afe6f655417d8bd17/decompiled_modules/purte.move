module 0xd934525c5e5230e54a4711815096d08a672e719e71aa8e5afe6f655417d8bd17::purte {
    struct PURTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURTE>(arg0, 9, b"PURTE", b"PURTEM", b"community driven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58892f1f-8ade-4e84-ab0c-95cb654679f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

