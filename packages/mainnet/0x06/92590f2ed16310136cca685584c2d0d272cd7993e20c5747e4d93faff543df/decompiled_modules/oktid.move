module 0x692590f2ed16310136cca685584c2d0d272cd7993e20c5747e4d93faff543df::oktid {
    struct OKTID has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKTID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKTID>(arg0, 9, b"OKTID", b"OCTOKID", b"Meme Octopus kid ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e457fb16-b29f-4ebb-9c66-7bd8824918d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKTID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKTID>>(v1);
    }

    // decompiled from Move bytecode v6
}

