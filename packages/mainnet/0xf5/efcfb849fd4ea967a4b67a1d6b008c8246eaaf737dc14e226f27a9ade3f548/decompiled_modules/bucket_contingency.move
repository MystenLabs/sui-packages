module 0xf5efcfb849fd4ea967a4b67a1d6b008c8246eaaf737dc14e226f27a9ade3f548::bucket_contingency {
    struct BucketContingency has drop {
        dummy_field: bool,
    }

    public fun burn_usdb(arg0: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg1: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<BucketContingency>(arg0, stamp(), package_version(), arg1);
    }

    public fun package_version() : u16 {
        1
    }

    public fun reduce_risk<T0>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::donor_request<T0>(arg2, arg1, arg3, 0x2::coin::zero<T0>(arg5), 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<BucketContingency>(arg1, stamp(), package_version(), arg4, arg5))
    }

    fun stamp() : BucketContingency {
        BucketContingency{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

