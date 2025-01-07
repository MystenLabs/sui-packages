module 0xdacf1ededc20a4faa8acf50fe39889355ed59784049bf7b42b6ce199e0508f7f::saf {
    struct SAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAF>(arg0, 6, b"Saf", b"Santa Elf", b"Explore, play and learn with Santa's Elves all December long", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_e873fe164c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

