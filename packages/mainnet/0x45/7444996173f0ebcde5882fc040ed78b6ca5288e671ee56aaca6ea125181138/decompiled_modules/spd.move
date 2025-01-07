module 0x457444996173f0ebcde5882fc040ed78b6ca5288e671ee56aaca6ea125181138::spd {
    struct SPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPD>(arg0, 9, b"SPD", b"Speedy", b"The return of the crazy driver", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9322edd-896a-490b-924a-4ee5abf6a611.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

