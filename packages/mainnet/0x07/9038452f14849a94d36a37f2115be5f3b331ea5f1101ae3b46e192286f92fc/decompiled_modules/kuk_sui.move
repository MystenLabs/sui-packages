module 0x79038452f14849a94d36a37f2115be5f3b331ea5f1101ae3b46e192286f92fc::kuk_sui {
    struct KUK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUK_SUI>(arg0, 9, b"kukSUI", b"kukkui Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqoDAABXRUJQVlA4IJ4DAAAQGACdASqAAIAAPm0yl0ekIyKhJRM7aIANiWkAFepf1rtd/q9dv/kOEHai/tG+ucf/pVqCmL/sf53PpD/te4N/Jf6/1of2A9jj9uTAvQkmKeG9/7vLy22di7VNFDLXV79KpLHs8VBv5iftTGVcD6BU1mkD1shHp/deSVfmKtE29rcwRt39dY3IBaZbpSy5ZQbTPTmGuMAiP6o4s2jQ7cYNz+2DVzASWa8G8lapkWYPoY/GYnx5DyfoyQ/ZCGkfrjk5I8UU9hifHHAA/vytEBjrdClrB9q1eRrlbfV0kP9vaofQhFiAWAe5m9byhSJg5WG23owdp4Yb/NZfH/537O30/swZwEv/7yXoUtvN8p/N5SgYoaIIi7/b3P5KLt5nEIilUc8czhpsd7hTqSM7Gq+mNln1sK+238vDxAr3D+1QXITaxsIskksHIkqvgJSXz/4avkoYn6ZfOzGyAT4I14LUqwyCfrduSgHvNa4GfHfn9Qw4iT1V/33r5ZjKHrCOz/rH9o213Z62n8Skb+7jiRvJGryTnaK3kDAn/YkymNtSKzc121E5vojzo9gzEQUdjLlEqJ1UwAV8FAgdrI+7L1E4/1EN38GTe2qepF4CWNAO4TvmacA4AkuxhabD93X/Gu/o4FHbx5p79X/vf17yDSt/woMPhUzcjIdHuhxjEqt99Pqwgdr7tPFoNFr49Z+S+ByFm/dsN/upPB85cZOJfu8sMGRwVJ32s+PBIAiHdShp8rvAaG675kqz99TvuXLSJloz+02UBo88sDTS0HeIfXSQYMFdv8Q388D95P29kHDHFqH7lOe/DQZ0gJmghmt8TRwCdEsaXdsLF/ZCNjv0I8irJ0GU0GZUU0+C5l+CaLXmLlnNaozVyh1rLGZuf6PZ733I0fABmojom4LSn/Nv9+fY6hpPtnRdK8zbrXFYX5vHYr2GsL7yrtSbY7S9UgCVHTBnHZJz7Mu+96bXb1RQcby3pU3UcVvoLFw/u6ZQlXvJ2I7HwT+BdTO4Vn7uQarAwFTwiGt7wFmSEZE5NF9ZDRFAR9F0uI110Y2e/eF7qdDhBP8m6Vd2L3ffsgC5t+lkL8PMxcX10x8z3mNwrd3OLbC4tTLXITVIFM5khWBgNDiDbqDXyWo3vzyHkSBlxvDrGocwZ1dbNKBcylofn0PhSZkQZormpqcsi0CpxgYAPdqvEnmP4wOnV5b6WDFrByeUPzVTzUCSwFEpDPwiIAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

