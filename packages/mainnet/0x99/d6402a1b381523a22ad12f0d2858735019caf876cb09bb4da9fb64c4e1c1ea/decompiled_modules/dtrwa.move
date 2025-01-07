module 0x99d6402a1b381523a22ad12f0d2858735019caf876cb09bb4da9fb64c4e1c1ea::dtrwa {
    struct DTRWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRWA, arg1: &mut 0x2::tx_context::TxContext) {
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::setup::setup<DTRWA>(arg0, 6, b"DTRWA", b"DT Drachma RWA Token", b"{\"description\":{\"Introduction\":\"A unique tokenized notes product that provides one-stop access to revenue streams from green assets.\",\"Investment Highlights\":[\"Competitive Returns: Attractive yields generated from tangible real economy activities, offering a diversified source of on-chain investment returns.\",\"Transparent Monitoring:Benefit from timely and transparent oversight of green assets, enhancing green accountability and minimizing the risk of greenwashing.\",\"Robust Credit Enhancements:Underlying green assets are fortified with multi-layered credit enhancement measures, including excess cash flow, performance assurances, and operational income pledges.\"],\"Product Features\":{\"Issuer\":\"Cayman SPV.\",\"Use of Proceeds\":\"Investment in Green, sustainability and renewable energy related assets located in Mainland China.The owners/operators of a number of these assets may use the AntChain blockchain technology to collect and monitor data regarding the performance and operational attributes of the underlying assets.\"},\"Disclaimer\":\"This is an announcement to record that the below transaction has completed. This announcement has not been reviewed or authorised by any regulatory authority in Hong Kong or elsewhere. Nothing in this announcement should be taken to indicate or imply that any party has been authorised or licensed to conduct any regulated activities in Hong Kong or elsewhere.\"}}", b"https://bafybeiaady5ccavpgfqr27kzv7b7ybesoez3hr6nncog4szj7wsvryctlq.ipfs.dweb.link/", b"USD", 10000000000000, 1000000, arg1);
    }

    // decompiled from Move bytecode v6
}

