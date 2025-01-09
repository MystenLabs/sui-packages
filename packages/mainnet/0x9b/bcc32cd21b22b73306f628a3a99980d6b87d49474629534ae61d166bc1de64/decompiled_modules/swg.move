module 0x9bbcc32cd21b22b73306f628a3a99980d6b87d49474629534ae61d166bc1de64::swg {
    struct SWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWG>(arg0, 9, b"SWG", b"suiwin ghost", b"I am the ghost of SUIWINgame, a memecoin! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48518a2ed4105f4501a18be8dc6c1be8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

