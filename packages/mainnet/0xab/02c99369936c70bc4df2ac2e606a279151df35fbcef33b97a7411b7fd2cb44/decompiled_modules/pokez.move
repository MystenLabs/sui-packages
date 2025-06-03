module 0xab02c99369936c70bc4df2ac2e606a279151df35fbcef33b97a7411b7fd2cb44::pokez {
    struct POKEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEZ>(arg0, 6, b"POKEZ", b"Pokecardz", b"Join the POKEZ revolution, the token behind PokeCardz. An AI-powered platform for creating Pokemon style trading cards featuring top celebrities KOL influencers, or simply upload your own image. Our", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7dm3hboxotl4mdn353mjafrhnsjwcrie25mdppneqfkhmupd4lq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

