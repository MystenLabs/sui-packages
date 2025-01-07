module 0x4e8337999c9b334a148387975eb28dc1ab8db64a2d60b90cccfcb3263dca2798::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 6, b"RRR", b"Rudolph the Rizzmas Reindeer", b"Introducing Rudolph the Rizzmas Reindeer  the meme token thats taking the holiday season by storm, one rizz at a time. With a nose that shines brighter than your crypto portfolio and the charm to match, Rudolph isnt just guiding sleighs; he's guiding you to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050583_f62610bb76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

