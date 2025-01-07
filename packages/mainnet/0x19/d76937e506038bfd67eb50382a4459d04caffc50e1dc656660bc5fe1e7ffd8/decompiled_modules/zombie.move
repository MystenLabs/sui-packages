module 0x19d76937e506038bfd67eb50382a4459d04caffc50e1dc656660bc5fe1e7ffd8::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"Zombie", b"ZombieVsSui", b"Fucking Ponzie Zombie is Here.. will make u Poor !!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_logo1_4787942375.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

