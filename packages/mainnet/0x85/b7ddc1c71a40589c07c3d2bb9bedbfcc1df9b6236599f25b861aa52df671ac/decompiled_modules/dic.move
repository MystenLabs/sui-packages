module 0x85b7ddc1c71a40589c07c3d2bb9bedbfcc1df9b6236599f25b861aa52df671ac::dic {
    struct DIC has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DIC>, arg1: 0x2::coin::Coin<DIC>) {
        assert!(true == false, 100);
        0x2::coin::burn<DIC>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<DIC>(0x2::coin::supply<DIC>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<DIC>>(0x2::coin::mint<DIC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIC>(arg0, 5, b"DIC", b"diCoin", b"Tiny dog. Huge ambition", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/EyUZz5nnvD_uFYTpbhy8Ko30kvL0dNhqyhlyLAE60hE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

