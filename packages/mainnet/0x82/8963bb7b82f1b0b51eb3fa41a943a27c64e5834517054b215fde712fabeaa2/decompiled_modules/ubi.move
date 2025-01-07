module 0x828963bb7b82f1b0b51eb3fa41a943a27c64e5834517054b215fde712fabeaa2::ubi {
    struct UBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBI>(arg0, 6, b"UBI", b"Sui Bolt Inu", b"Bolt in will be the fastest meme coin on Sui to reach 100M Marketcap because liquidity is destroyed Catch Me If You Can", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?imgurl=https%3A%2F%2Fres.cloudinary.com%2Fjerrick%2Fimage%2Fupload%2Fv1704818270%2F659d765dfbed18001d39a7ea.jpg&tbnid=ZznZPnACO_D09M&vet=12ahUKEwj80IGlvtyEAxXhOFkFHZmYDTUQMygIegUIARCEAQ..i&imgrefurl=https%3A%2F%2Fvocal.media%2Fmen%2Fusain-bolt-the-lightning-legacy&docid=IegzIcTFX4SIiM&w=1024&h=576&q=usain%20bolt&ved=2ahUKEwj80IGlvtyEAxXhOFkFHZmYDTUQMygIegUIARCEAQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UBI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

