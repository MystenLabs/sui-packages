module 0x8f79d47c5833837533c917ec37d676624a4ca55f9343d299f8b6bb4260e5dc5d::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"DEGEN", b"Sui Degen", b"Calling all DEGENS, just trust me bro...buy the bonding curve...let's graduate and push this to the masses.  Get rich or degen tryin'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a281533552cb2774d9472e018d2ab72cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

