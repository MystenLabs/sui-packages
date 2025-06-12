module 0x9db313733c2533bcc3db3d742eee29c7c2d81da05782f5aca5c3a01831eb70f::eggdog {
    struct EGGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGDOG>(arg0, 6, b"EggDog", b"EggDog For Sui", x"24454747444f47204d455247455320544845205255424c452057495448205448452049434f4e494320434841524d204f4620454747202c20534f4c4944494659494e4720495453200a524549474e20494e205448452043525950544f20554e495645525345", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiap27n2rdyufj5qutaq4655uqksw7gu57yroay3ooopkduvr5in7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EGGDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

