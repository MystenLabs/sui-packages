module 0x71a7fd4b4045d46b910a20cd540d97a2f6b778632f3681dc14f2eb3d6b812302::peoples_sui {
    struct PEOPLES_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPLES_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOPLES_SUI>(arg0, 9, b"peoplesSUI", b"Peoples Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkQFAABXRUJQVlA4IDgFAAAwGgCdASpwAHAAPm0ukUWkIqGZyiTYQAbEsoBprBDqkIzmefDeyI8COFfSRM3klb49zXL76ie81oxNoiZ5tjSIvLOgYy1Cuaj5SNTdBCYNyHQL4Txv86R24+Bkwl2btJncCQA/GEorN7o9sJTwCUhpU9Z22qRPj656z+cr7er5ipZuOdYj46zQP19ZJnsnbb0CJaSYjvi4D3euMQ+6PAzmqmBCUYZczYxvOjeB/lfPRtHS1FvbWc0d1YY6XJz8Q9UhVf1w5qJDjKcXyGlFLZ8wvKXdqk1sMhtoAAD+/ToD3pKdyZcvX68oE3Y+4/cd9ZLl3zvuJZuQ2vDkh/i/EciZXttxravTxtyd00gXS5kvu/8yJnNcXQLozSS/mixzhaS253Dnw4bqxydERZG4HtM/3dX7JsyxvPN4ISICiLEbjh61HcCIGIWgmZ1kxoocjA+29c67VwQw6lWwfvdq7m5ICgE8Do4yytjh89b3dgKtNnGdLnztYi4+MVmCK6qDT6y+glJWCbBleB9DyNqUmkr4Ul4/BCPRN5Kmb/psS/Wz33/99lIh9G23XlsQpOnYE55EwelkXnh85SuNeAUT06rKZeS8srLWWnfgPSHvZsPh/d/Qe1MdW3g+NdXbYdIZmtZsv/hSz9OsWjzZ1x25MrMsqiVM6b3fquEFzAnStkEaUf+/YL4PXGXlDbMwNUD6VUZkKK79FTj23mmOcL0q8CilnLy6uLbxofn2BTzmiN0oDLFzF3tBW+SSWvC3X8mhzHsp5j8yoLhV2TmHjs7qdOjH+RyDQ74BEhR4R8R6ibXnEsjgo90XEkvX5hNWfH6mS5eCMJpfR7vmDWf2V5ervHsSGPJs9WAMPwZjlhts/IArd2Imi1AS9LoytcIS5aN5Lr19lkTKgJcOYW1iLbXyc/25WUq9ttsJWx5bsECOJvTVW/RJuWMgqBerANEwQFwk8ppWcQJdFyD1I4m3Zhs4wkdaJglzgqDPtIcTxICaAh2duLNf2LuXxVeH1h1tcoU79wkyEMTigpiNSV+YjaiuIvyCJto9Qv+uq3s7+QVeypi8e+wQf/m1olJYsnr5lYILrhF9OnvOo1+oIqyylDo/I1h9m5ezcev2Gda+jTAt4mChdyVIwF7jU/zrApmQmGtbW+nZmceYD2076I2XZwkDlfg8ETWmTMpd6sP24gOsvUETOd634jQUT3xmfyOPe6gRfQ2bv6g6iYfsMO36ljAYLaFzhFNmNfWbWMA75r0ZGQFiouZeSqx4Y0E/TWOS1bJZF6hquFpZ7bRC+Eq74ydn7zAeDIjS4Z2nnHNnApNDxswWiC5u5uLDHVEIbGeeqP1a9Lcfi3norwEn2Z87MrdF4wjIEmjV8piNYJ3ItvXGzG5h9mcP4TSGngDWP2rAYuBVoyQZX/MvtCdEHX+wvBon3V0dJnWt+Ga9hcke13pV6llpKz5o9CxngVE12CXEWBrtbvu15AgbBd1P1DZA4CUSbKR5WNoK2moqr2KsWzc54lB3RkpNoolHoTuIv1beJd8zydnEW7NMBcTJbfFqL1MYbW5C6zbAVQI/j8O3GzxO+YzG2EXseG8AizjEZWpKzc1XBJgjGCarBoYqp4iDnNqk/PlSWr4pDcjH0TEIeqtF6iZVAYNu2CI2XGfNBeoEJyapZoaNitgotw5nIfuBhn5jg+359o6dgAcbsa5c3jYIWK6/gasfbwxMRSfAaN4rOqv2LeITTr/UmZqi1dXsJR08VlTZd7dW0b2SSghx1sS+AG1Zs7fNa6AAAAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPLES_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOPLES_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

