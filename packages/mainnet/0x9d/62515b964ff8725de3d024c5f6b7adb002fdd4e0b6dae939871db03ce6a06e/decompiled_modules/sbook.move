module 0x9d62515b964ff8725de3d024c5f6b7adb002fdd4e0b6dae939871db03ce6a06e::sbook {
    struct SBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOOK>(arg0, 9, b"SBOOK", b"TheBookOfSuiLegends", b"TheBookOfSuiLegends is an epic archive of the funniest, most iconic memes and moments from the Sui universe. A legendary collection for those who live for clever humor, inside jokes, and viral content related to all things Sui. Dive into this ever-growing book and become part of the legend, where every meme tells a story and every laugh echoes through the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1783930395307716608/LrRqtvTp.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBOOK>(&mut v2, 1400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

