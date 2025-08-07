module 0xdba66bf135e918de2181ac5b757baee1c96c24167fe3ce338623492714dff91::pgn {
    struct PGN has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PGN>, arg1: 0x2::coin::Coin<PGN>) {
        assert!(true == false, 100);
        0x2::coin::burn<PGN>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PGN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<PGN>(0x2::coin::supply<PGN>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<PGN>>(0x2::coin::mint<PGN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGN>(arg0, 5, b"PGN", b"Pigeon", b"Tiny bird. Huge ambition", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://contenttest.digitalmind.rs/db8ce7b9-8dcd-42cd-88f9-aa880542dd2e-Pigeon_on_high_tension_cable.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

