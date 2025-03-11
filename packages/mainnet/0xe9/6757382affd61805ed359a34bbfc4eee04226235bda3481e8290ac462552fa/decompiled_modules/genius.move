module 0xe96757382affd61805ed359a34bbfc4eee04226235bda3481e8290ac462552fa::genius {
    struct GENIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIUS>(arg0, 9, b"GENIUS", b"GeniusX", b"Genius Token ($GENIUS) is a revolutionary blockchain-powered asset designed for visionaries, innovators, and forward-thinkers. Built on cutting-edge decentralized technology, $GENIUS fuels projects that drive real-world impact, from AI-driven solutions to financial inclusion and sustainable development. With a mission to empower intelligence and progress, Genius Token fosters a global ecosystem where ideas transform into groundbreaking solutions, solving critical world problems through smart incentives, funding mechanisms, and decentralized governance. Whether in education, finance, or technology, $GENIUS is the key to unlocking the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a6a0cee3ce545c0465e3cfba5d080a25blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

