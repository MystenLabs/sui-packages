module 0xe96ebdc882d86235cd08e465b8a686697d78029d811b0c515419e9c5c8f80a06::pocoin {
    struct POCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCOIN>(arg0, 9, b"POCOIN", b"PolOfSad", b"Pol COin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1901a28a-b9bc-495b-8354-ee3f7774077f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

