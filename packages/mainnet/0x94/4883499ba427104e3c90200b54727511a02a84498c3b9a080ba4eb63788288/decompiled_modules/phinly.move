module 0x944883499ba427104e3c90200b54727511a02a84498c3b9a080ba4eb63788288::phinly {
    struct PHINLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHINLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHINLY>(arg0, 6, b"PHINLY", b"Phinlycoin", b"From the depths of the crypto seas, PHINLY emergesa half-dolphin, half-human legend on a mission to transform FISHES into WHALES. As the fearless guardian of blockchain treasures, PHINLY guides his pod to unlock exclusive rewards and life-changing fortunes.  $PHINLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056349_f90450c1d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHINLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHINLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

