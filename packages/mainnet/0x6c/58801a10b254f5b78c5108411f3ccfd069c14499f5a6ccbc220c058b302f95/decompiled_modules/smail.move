module 0x6c58801a10b254f5b78c5108411f3ccfd069c14499f5a6ccbc220c058b302f95::smail {
    struct SMAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAIL>(arg0, 6, b"SMAIL", b"SuiMail", x"4120646563656e7472616c697a6564206d61696c696e672073797374656d206f6e207375690a20666f72207365637572652c20707269766174652c20616e642063656e736f72736869702d6672656520656d61696c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibepg6mhtydeg4wvnm7k34ydnxxvcmhqia26xqm2o2ybz3lgmb6uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

