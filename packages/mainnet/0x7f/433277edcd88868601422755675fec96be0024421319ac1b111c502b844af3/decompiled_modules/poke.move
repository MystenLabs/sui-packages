module 0x7f433277edcd88868601422755675fec96be0024421319ac1b111c502b844af3::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"POKE", b"POKEMON INTO THE PSYVERSE", x"504f4b454d4f4e20494e544f205448452050535956455253452069732061206e6f6e6f6e73656e73652c2070757265206d656d6520636f696e20746861742064697665732068656164666972737420696e746f207468652077696c642c206e6f7374616c676963206368616f73206f662074686520506f6bc3a96d6f6e20756e697665727365207769746820612070737963686564656c69632074776973742e204275696c74206f6e20746865206c696768746e696e67666173742053756920626c6f636b636861696e20616e64206c61756e63686564207468726f756768204d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpp2bratonluobnfzndmj26hjbca6pottit7kyhb6wi4s7k2vx3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

