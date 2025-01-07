module 0xd036bfebaf47e7f6704b369ad573adb429018d691657ce90a326358bb0755420::dwif {
    struct DWIF has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DWIF>, arg1: 0x2::coin::Coin<DWIF>) {
        assert!(true == false, 100);
        0x2::coin::burn<DWIF>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DWIF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<DWIF>(0x2::coin::supply<DWIF>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<DWIF>>(0x2::coin::mint<DWIF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIF>(arg0, 1, b"DWIF", b"birdwifhat", x"2444574946202362697264776966686174203a2049276d206120726564206269726420f09f90a62077656172696e6720726564207769662068617420f09f8ea920616e6420736d696c696e6720e298baefb88f2c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/ZrjIJdTp69Fsx7ierH30RslrrSYMvwffX9tj-EDRr8Q?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

