module 0xa183bebec1e8753634aa0edc6ad4b7cb7c7a9b718b3ffb19ea21fd6c113e7fb3::pawcat {
    struct PAWCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWCAT>(arg0, 6, b"PAWCAT", b"Just A Cat", b"The ultimate cat meme token on the Sui Network! Fun, staking, and powerful tools combined with endless purrfection. Join us and leave your pawcat print on the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpic76a5caaei3ddfmioocarhazp2tl3fuqvfwaioghqv7r7iteu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAWCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

