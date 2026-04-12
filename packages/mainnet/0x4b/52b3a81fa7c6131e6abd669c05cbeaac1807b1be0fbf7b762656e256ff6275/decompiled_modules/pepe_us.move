module 0x4b52b3a81fa7c6131e6abd669c05cbeaac1807b1be0fbf7b762656e256ff6275::pepe_us {
    struct PEPE_US has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_US, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776005771826-d0760b21f00bfdc0bfc20007cb734dd6.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776005771826-d0760b21f00bfdc0bfc20007cb734dd6.jpeg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<PEPE_US>(arg0, 9, b"PEPE US", b"Pepe USA", b"us pepe", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<PEPE_US>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_US>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPE_US>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

