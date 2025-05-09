module 0x1177db959b097d24258470072e87277369e1986b8793d77fc9ba54ce0d907aac::podex {
    struct PODEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODEX>(arg0, 6, b"PODEX", b"POKEDEX ON SUI", x"504f4b45444558204f4e205355492050726f76696465732061207365616d6c65737320657870657269656e636520746f206d616e61676520796f757220506f6bc3a96d6f6e204e465473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab3irmgksklippz7vh5ryr7dhqmn2u7xvnn5cfxymjmqgbro52qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PODEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

