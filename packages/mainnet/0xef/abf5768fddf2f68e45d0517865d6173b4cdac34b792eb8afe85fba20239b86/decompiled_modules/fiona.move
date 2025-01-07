module 0xefabf5768fddf2f68e45d0517865d6173b4cdac34b792eb8afe85fba20239b86::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FIONA>(arg0, 11755381338648105763, b"Fiona the sheep", b"Fiona", x"46696f6e61207468652053686565702c20323032312079c4b16cc4b16e646120c4b0736b6fc3a779612764616b69204d6f726179204bc3b67266657a69206bc4b179c4b173c4b16e64616b69206269722075c3a77572756d756e20646962696e64652074656b206261c59fc4b16e612067c3b672c3bc6c64c3bcc49fc3bc6e6465206b616d756f79756e756e2064696b6b6174696e6920c3a7656b656e20626972206469c59f69206b6f79756e647572202e205b2031205d", b"https://images.hop.ag/ipfs/QmeR781HAwukUGhQjt5EbAacXsGn6e1EbcN5mNoVKBtoA8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://en.wikipedia.org/wiki/Fiona_(sheep)"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

