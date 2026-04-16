module 0x11b9d694d4d7ad5e66754e34c6df11d9fd4618249230b6bd3c0a486f8e529733::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 9, b"OCT", b"Octopus Coin", b"Octopus By china holding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776362971491-85e615e539760a2786487e8755c724a7.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OCTOPUS>>(0x2::coin::mint<OCTOPUS>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

