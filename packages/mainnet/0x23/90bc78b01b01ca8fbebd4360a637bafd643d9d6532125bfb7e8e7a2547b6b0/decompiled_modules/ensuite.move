module 0x2390bc78b01b01ca8fbebd4360a637bafd643d9d6532125bfb7e8e7a2547b6b0::ensuite {
    struct ENSUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENSUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENSUITE>(arg0, 6, b"ENSUITE", b"EN SUI TE", b"Dive headfirst into the crypto cesspool with ENSUITE the ultimate degen meme shit coin en Sui blockchain! We're not just playing with words; we're flushing the old norms down the drain. Featuring our audacious mascot 'Te' the fox on the throne, we embrace the true spirit of meme madness. No sugar-coating, no pretences, just raw, unfiltered fun. Fairly launched on Move Pump, ENSUITE is the wild ride you didn't know you needed. Grab your TP and join the flush party because when it comes to this shit coin, we're all in it together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ensuite_b930b0e741.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENSUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENSUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

