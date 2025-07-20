module 0x9eaf64622df7557e185b5cd38f9e769487d014728fd2b378a997a1dbeb49f484::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PAWMI", b"Launch a project on @suilaunchcoin by tagging @Pokemon and including the project name and logo. $PAW + PAWMI https://t.co/Bz2cr4wBem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/paw-8y9jlf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

