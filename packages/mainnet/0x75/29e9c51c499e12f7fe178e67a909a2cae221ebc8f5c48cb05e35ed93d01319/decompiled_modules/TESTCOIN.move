module 0x7529e9c51c499e12f7fe178e67a909a2cae221ebc8f5c48cb05e35ed93d01319::TESTCOIN {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: 0x2::coin::Coin<TESTCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(0x2::coin::mint<TESTCOIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTCOIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOIN>>(arg0);
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TestCoin", b"Test Coin", b"Test Coin Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut leo vitae lacus consectetur dignissim. Phasellus at elementum quam. Proin pretium et leo a fermentum. Duis lobortis dignissim metus, at tempus nisi accumsan eu. Aliquam semper turpis ligula, id volutpat massa tincidunt eu. Cras scelerisque ipsum a convallis sollicitudin. Vivamus facilisis scelerisque nisi sit amet elementum. Curabitur eget lobortis quam, ut fringilla ex. Sed quis ante non justo eleifend condimentum. Sed efficitur diam lorem, sed hendrerit ipsum dapibus sed. Etiam mattis nibh eu augue fermentum, eu blandit elit vulputate. Praesent finibus enim quis nibh pellentesque scelerisque quis tempor augue. Aenean in rhoncus augue. Phasellus pellentesque lacinia libero, et condimentum ipsum luctus vitae.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_6882b96f72c0c7.09110113.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

