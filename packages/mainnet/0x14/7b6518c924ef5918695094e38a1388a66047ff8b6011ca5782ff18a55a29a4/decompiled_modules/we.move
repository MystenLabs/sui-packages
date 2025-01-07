module 0x147b6518c924ef5918695094e38a1388a66047ff8b6011ca5782ff18a55a29a4::we {
    struct WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE>(arg0, 9, b"WE", b"Beowe", b"Beowe is memecoin. Created by Beo with the spirit of dedication to the meme on sui is strongly developed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9df04d6-6b82-47d9-a896-16e44f019d12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE>>(v1);
    }

    // decompiled from Move bytecode v6
}

