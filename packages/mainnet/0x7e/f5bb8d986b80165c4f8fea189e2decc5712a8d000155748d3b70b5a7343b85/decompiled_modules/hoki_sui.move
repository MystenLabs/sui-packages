module 0x7ef5bb8d986b80165c4f8fea189e2decc5712a8d000155748d3b70b5a7343b85::hoki_sui {
    struct HOKI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOKI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOKI_SUI>(arg0, 9, b"hokiSUI", b"Hoki Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRnYEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBoAAAABDzD/ERHCTNs2ZlD+TPcFxaSI/gdcVQ28e1ZQOCA2BAAAMBYAnQEqgACAAD5tNJRIJCKiIaQUC0iADYllANYkBnxmC3a7jKbaDzAedR/gPVX5M3WMegB5aPstfuJ6SzSD2my2dJTNK8jLGczv+uZEGgumC86+9sYBQKRP8IyF5Y73zgt5NmaUptZkxVWgPJ4huBmlxBXzgFC9VjUsvFa0sAot6ZmWQ0+iiOFs2ILJ6iv1nrudZGwgUgdjU7/0zWatDVDAtak1aSLaYx1AC0xYk8VeGl1TJgAPq49AAP78+G6/L54L80XNDVcEX+JhFnt2FFvlGXN/QAoKT6+hhAMbT56KylSSEsodPpv/2q4Vvk0YYhyducsR4j+///VM/0O76XNEPb/nrnZSpI00jwb40s3EB4tx5NiL7Qg/4M1tRMtP32ZKXonMrETk3KwruLvVHfJWEaZ5S9Uou7rfpFxp4nbdtJbT575+cpp3GOi53MQX8dTz8fUNB4xImqkdHBrfMJjkxFmVLaVwbsk64wQTexMYlPUqwdkN8Bqmgev7ro8+L7CEN5a7HZe6n+I/qrEj7ozRcn+dvW8s777f/tYP/dXQ9+RIouJR/8qOR/dXxpMKa4AD0yEuF/5em1H7Tw/QRQV8h4wINYyTKnzhl6kICQZ5FduS70MGQv1+iWWj94Ek873H3LNINey09daHOyXMhk1r6CmIBgMx8Z0yBRIPYbGbuTXIB0lSbTRdjIW2O7GLBgq//PPBmODa+zzlThvg0J1lfS6gfXqnubea2Sv+C1X1BJYPTB5AMyLzeRqjC8og1NAlPZhVHe1TUfJD/JFar7RX6pcG//gz8r+mwPEqKLp/rQuZcBen/UQH1D8In8N2LS+oY3ftra9d+sZfIEPV733PvppPr4lC1Tdv1P0G23TB8UoTvivT3/WFLZCetq2nwIjXNKbm+xuU+6SyYi2Ia7fVVCI1VV0SCRS/S3NY7VpbmeWxN/mV50pOw6SSSLonEjn7mlMcUXBZ7OKs964d39TOvq52vCibBHPO258+JcmqZjJMxnOOtYY7WlgLCfqfaF2xxi8v3dId6GZOGI8kODQwTR9KrdvbT/b4RPlmBsUFVMYOvX6OnQN8LL2+7OigXRy6od+V6QjV7d07IuaOREPZLiN0mvfglUAs/v3/t+fh74YmObu0pJ3GLN/NaeSTf0HM1MRiFHVqGWHLiyCR6Bsy75Ow8nWji8ebPTac0kwbztG7NPW4AEmUwWhi5KWkt2NqdgMp6srOrQQFs4SelwR/uwL33PEbxTPqhVvNA/BusD35C+ld4FiICrSHnWlBXbNGgjZ4s/NQ/5XynlL71KpXXHwlmiQxyqW3+ozEUhQfkzxVHjWOnpJVJap8z+MN2w4QO/cDQAShVsK0JbyJrxxjGEJcwpYbTQ2K7Bnx3j5aeI5knZfZOJ8c03QOnMGEkMln7BILu+SyemrO+uwIKgeFpAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOKI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOKI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

