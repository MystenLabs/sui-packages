module 0xd4751b26b09c92b571f8db3a0a786ce8e2cf066bb665313e00a08bbdc0912d32::krg {
    struct KRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRG>(arg0, 9, b"KRG", b"KORGY", b"Introducing KorgyCoin, the cutest meme coin inspired by the internet's favorite stubby-legged friend, the corgi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/017e9512-c2d9-43e3-bfcc-a356e42e79f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

