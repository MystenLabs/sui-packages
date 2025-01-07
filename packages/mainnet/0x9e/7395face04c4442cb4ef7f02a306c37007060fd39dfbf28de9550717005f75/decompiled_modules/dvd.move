module 0x9e7395face04c4442cb4ef7f02a306c37007060fd39dfbf28de9550717005f75::dvd {
    struct DVD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVD>(arg0, 9, b"DVD", b"Davido", b"Meme Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5df21df3-44af-48fd-a3eb-5ba8eb94298d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVD>>(v1);
    }

    // decompiled from Move bytecode v6
}

