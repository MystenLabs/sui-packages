module 0x4e4019307cee9462b240e49a549022d36ca3fd19a2b8b0324045d9701bb4181c::metamonopoli {
    struct METAMONOPOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAMONOPOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAMONOPOLI>(arg0, 6, b"METAMONOPOLI", b"Metamonopoli on sui", x"5375692078205061726f64792078204d656d6573207820436f6d6d756e6974792e204d6f6e6f706f6c7920697320666f7265766572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241213_153547_932_6513a90855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAMONOPOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<METAMONOPOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

