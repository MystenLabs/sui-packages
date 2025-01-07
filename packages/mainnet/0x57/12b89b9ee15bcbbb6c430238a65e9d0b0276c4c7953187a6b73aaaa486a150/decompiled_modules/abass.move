module 0x5712b89b9ee15bcbbb6c430238a65e9d0b0276c4c7953187a6b73aaaa486a150::abass {
    struct ABASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABASS>(arg0, 6, b"ABASS", b"American Badass", b"Hey look ABASS!. Die hard American badass, Trump is king, Fuck your mom. Sending it for good Ole Uncle Sam! No socials till after graduation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005027_be49174adb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

