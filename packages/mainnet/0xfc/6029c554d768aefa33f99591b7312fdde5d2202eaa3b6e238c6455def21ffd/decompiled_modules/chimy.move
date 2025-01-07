module 0xfc6029c554d768aefa33f99591b7312fdde5d2202eaa3b6e238c6455def21ffd::chimy {
    struct CHIMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMY>(arg0, 6, b"CHIMY", b"ChimyDogOnSui", b"$CHIMY is the most unique and lucky Dog in the Sui ocean, staying true to its roots and bringing wealth and dynamic energy to the Sui Network. With the lore of the legendary smart dog, symbolizes intelligence and ingenuity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001321_bcd03f9c95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

