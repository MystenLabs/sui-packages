module 0x4f5df89e29ab05a33c2ca681cd672b5f938ca625e5fe1200267daefac68e99e3::nyc {
    struct NYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYC>(arg0, 6, b"NYC", b"New York City", b"The New York City token is a digital asset inspired by the energy, culture, and global influence of the world most iconic metropolis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiq3itpsj6fpdxiea2dqorzhppaxw4hs3saoxvmzfmv6z6e5qm2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

