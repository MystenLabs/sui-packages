module 0x42bd6180565b9bd294089ef01408e9d8f6cea15e5911e736a69f4930653a7803::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUINT>(arg0, 2403743982885120179, b"SUInta Claus", b"$SUINT", b"Let's pump this token and MERRY XMAS...", b"https://images.hop.ag/ipfs/QmXcFwWaCHrxe9ML8Vs3RxAHQzvkVJzhpttkjpCsaF2b4B", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

