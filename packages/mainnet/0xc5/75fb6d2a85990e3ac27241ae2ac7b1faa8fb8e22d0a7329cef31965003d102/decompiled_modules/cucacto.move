module 0xc575fb6d2a85990e3ac27241ae2ac7b1faa8fb8e22d0a7329cef31965003d102::cucacto {
    struct CUCACTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCACTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCACTO>(arg0, 9, b"CUCACTO", b"Cucacto", b"Cu cac to vai loll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0c7a790-14ee-47fd-9e70-022ce8874df3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCACTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCACTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

