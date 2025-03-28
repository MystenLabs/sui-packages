module 0xdb32cbebd4cf809af2da364ee7d4458d53b4dfe1ca3c6e77d5001da5206243ce::lull {
    struct LULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULL>(arg0, 9, b"LULL", b"Bullull", x"42756c6c756c6c2069732074686520756c74696d617465206d656d6520636f696e20666f72207468652063727970746f20636f6d6d756e69747920746861742074687269766573206f6e2062756c6c69736820766962657320616e642068696c6172696f75732062616e7465722e204e616d65642061667465722074686520666561726c65737320616e6420736c696768746c7920636c75656c65737320737069726974206f662074686520657465726e616c202262756c6c206d61726b65742c222042756c6c756c6c20636f6d62696e657320746865206368616f73206f662063727970746f2074726164696e6720776974682061206c69676874686561727465642073656e7365206f662068756d6f722e20204b65792046656174757265733a20507572652042756c6c69736820456e657267793a2044657369676e656420666f7220686f646c6572732077686f20616c776179732062656c6965766520746865206e65787420415448206973206a7573742061726f756e642074686520636f726e65722e204d656d652d506f77657265642047726f7774683a204576657279207472616e73616374696f6e20636f6e747269627574657320746f206120636f6d6d756e697479206d656d652066756e64e2809462656361757365207768617427732063727970746f20776974686f7574206120666577206c61756768733f205275672d50726f6f66202857652050726f6d69736521293a20546865206f6e6c792062756c6c20796f75e280996c6c2066696e64206865726520697320696e20746865206e616d652e2042756c6c277320536861726520526577617264733a205374616b6520796f75722042554c4c554c4c20616e64206561726e207061737369766520696e636f6d6520746f206675656c20796f7572206d6f6f6e206d697373696f6e732e205461676c696e653a20224368617267696e67207468726f75676820746865206368617274732c206f6e65206d656d6520617420612074696d65212220204a6f696e2074686520686572642c20686f6c6420796f757220686f726e7320686967682c20616e642072696465207468652042756c6c756c6c207761766520746f20746865206d6f6f6ee280946f72206174206c65617374206120646563656e7420636875636b6c652e20f09f9082f09f8e89", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAD6APoDASIAAhEBAxEB/8QAHQAAAgIDAQEBAAAAAAAAAAAAAAEGBwQFCAMCCf/EAEYQAAEDAwEFBAcFBAkEAgMAAAECAwQABREGBxIhMUETUWFxFCIygZGhsRUjQlLBCGKS0RYkM0NygqLC4SUmNPAXsmOD8f/EABsBAQACAwEBAAAAAAAAAAAAAAABBQIDBAYH/8QANxEAAgEDAgQEBAUDAwUAAAAAAAECAwQRITEFEkFRImFxgRMykaEUscHR8AYj4RUzQlJicoLx/9oADAMBAAIRAxEAPwDmCin0pUA6M0qdAFFKigHRmlRQDopUUA6KVFAOilRQDopUUAU6VFAOilRQDopU6AM0UqdAFFKigHRSp0AUUqKAdFAp0AulKn0pUAUUUUAUUUUAUVmG2ThaRdDFeFuL3YCQUncLmCd0HvwDWHQBRRRQBRRRQBRRRQBRRToBUUzSoAooooAooooAoora6ZscrUd6j2yAppL7wUrfeXuIQlKSpSlHoAAaA1VFZ15tc2y3J6Bc4648pk4UhXyIPUHoRzrBoAooooAooooB0UCnUAVKn0pVICiiigCpNo+yRJnb3W+uOM2KCQXyj231nillH7ysc+gya1Wn7RKv15h2yAkKkSXAhOTgJ71E9ABkk9wq4dEadZ1vqyHaYCf+0rErdTgYEp3mpxXeVEZ/whIrGUlCLnLZGUIubwjQG+TtRaO1qxPaEaDBixHoMFA3W4oEhKQEp7ylxWTzOcmqtq0NSzUi17RJjeA3PuzEFsDohK1ufRtNVeaybzqQ1h4FRTxUt0Ds/v8AriaWrLE/qzfF+Y8dxlkd5UevgONCCJVKtHbP9UawV/0C0SZDIOFSFJ3Gk+azge7nVghezjZm4trshrfUjZwpRO5CYV3Dnv47+PuqN6t2n6x1M2W5tyFqtmMNwoQ7BtKe4JHrKHmSKhtLclJvY3R2TWHTrn/f+ubZb3k+3Bt49JkeRx7J8wa9Dddi9l9WHYtQX91P95KfDSFeeMfSqk3oyFE7q31fvndT8BxPxFMy3B/ZNtNDoEoH1OT86jL6InC6stNe1PS8fKbPstsDaehluKkn35Ar5/8Al17H3WzvRCUd32ST/uqsmjcXuDPpSh3NhX6Vmw4DsiNMbcefRc291TMZQVvODjvY8eRA86wlU5TKNPmeEWANrFqdO7ddmWk3UnmI8dUcn3jOKyE6q2RXdO7ddD3O0LP47fN7QD+LH0qr3Y93jj71qe0P3krFYpkv/j3V4576AfqKyjPm2wzFxSLVd0Js81Ar/tDXiYEhXsxL612WT3dqMD5Go/q7ZFrLTMdUuTalS7ekb3pcE9u3u/mO7xA8SMVCS5Hc/tGOzP5mlH6HPyIqS6S1lqbS7gVpe+SGUJOTHKspP/61ZSfdU83ccvYiNKrq/ppofXrfo20GyJsN4VwF5tTZCd7vca458efuqMa+2VXjS0NF1gusXvTrvFu5QD2iAOm+Bnd+njWRiV5U12Y7of1Mv+8RYpRbPcr1QfkVVC6lmy9W9q9qKfZmx5EQjvK2VhI/i3aLcG3tLStQ2a22PUIS3KfZJsdxcVjkop9HWeqCRgZ9k46GoDMjPwpb0WW0tmQystuNrGClQOCDV/aG0uzrfYUY+Ei4WyU6GHOqOSvhxquNVMK1BYl3d5KkX+1KTFuzShxcTndbf8Tw3VeST144xqKcpLqmZyhypPoyBUUUVkYBTpUUB9UUhTqAI0qdFSBU6KOlATrTUVy0aLmXZsH7RvDptVvSn2t3h2yx55Sj/Ma6j2T6Zb0tokJSlIdDSipQ/ErGVK+PDyAqjdP23tNf2C1LH3Vitjbi0dA8sb6j57zg4/uiuqosYCztxhwyzu/EVW8Qqaxp+5220MQc++hw5eHSrZ3HX1lXqS4vx3W28f8A3V8ahtTq6294aLu8AoPpNju6lvN44pbcHZlR8AptA/zCpToPSlq0fpxrXe0BnfCvWs9nXwVMXzC1A/gHA8sde4GzlucRiaL2cW+DYU6t2lyHLdYOcaCg4kzzzwkdEnlnh7hxrD1xtMumqIibVZmm9PaUj+q3BjeokjvcUOK1eH/9qO601Vc9Z3py9aje3iobrEdBwlCRySgdEjv61pYUWbep7MOCwt99fqtstjkP0Hea1SlhN5wl1MlE+Y7jYfbajENlagkvuDJGTz8PdxqYt7KNWvzGmnIaU9oVFT63R2aUg4CirJ588c/Cp9o3ZhbbEhmZqLcn3IYUIw4tNHpn8x8+Hh1rL2qalnxLWly3XpqFJbPGNlP3ifAHqK83U4zO4uY29hh50cmnjyxjX9C2p2CjTc7j6I1lo2QWaAErvtwenOjmzG9RHlnn9KiaLNIh7TJtv0/6NGdSkuRI8pIcbdG6DuZVniRnB8OYr002db6qhSH7dcZfatDeSlbXZodH7iwN0q8DjzrCultuLt1gyIl3lTtSsuJHoTsVTchkpOeJBIKR35xg1vt4V6dWpC4rqUmsYw8J75axhLz+5E50uSLpwaWd+/vkz16i1jabneL79niIygojSYxRhDSt3CVBPQZGc8snHWsBcu3O6FXNdtd3N4VI7c3gJ9TtskBO/wDlxk+Yq32dNTrwY8/X0tl0I9ZNua9WMg9N8/3h8+HmKkjcqGrDK4rCWXGUJ3VJQUKaVwCd3kU8OXLFV0+MUKPKlTTkms8jwsLZZfzfl6nXTs61RNuWmuObz646FKWnVWu5DsO8RoqprEwGC2xuEtrWkA75HIcSePDkelY0O3S7jtQiw9QuMznG0l2ay2kBpHAnsxjgcZGT3n31Zdw0teNMl6XoJ8dgolS7RIJU1nvaJPqnw69/IVUtjt9yfnz5Au01nUrzi0rt8aMovqVnPrKJASnPXlj4V22tejXjUrW/JGLjhNJ8yztzJbY77PfJz1FUpSjGrlvOfL275LFvGyvS903lW5yRaXzyAJcbJ8jxHxqFydiuoG5DnZyIbkRJBD6VHinjk7vPIwOHjwNeOrP6ZaUjxvTrxNXIcTvLS22VNtA8gXCMFXgPjU+2aX95dnQJN9bm3B47ym99PqDokD6muSc+IWVt8elXVSO2zf3x+ZmqdtcVOWUHF/T9SgFPlJU0+kuoBIG/wWnyP6cqleg9cX3Q8pUmwyu3t7nCTBfG804nqFo/3D+Yq39XaHsurUqd3E267EcJDSfVcP7yevnzqhtR2C66Uuno1yZUy6OLbieKHB3pPUf+mrnh3FaN8sQ8M+sX+nf+ZK+5tJ0NZax7lo3XR+n9p1qk37Zs2mBfWUlydp5asZ71sHqOuPocCq40AHYe0KxJWhSHm57SFIUMFJ3wCCKwbPc5lsuke62N9yFco6+0SWju+8eHenu+FXMm/wCltaRWtdTizZ9V2RSXZ0dCfu7iQD2ak9yioDPkfA1bJ5OPBMv2XQE2vVkMesy1cTujpgpx/tFRLahamNJbQ2Lq+1v2W470C5NAe02sYKvPdOR4oqwP2YbM/A0C9cJSSld0kqkJ3hxKAAkH34Jr6/aCtCbjpyekDLiY3bo4fiQSfoMVWyrcl42tm8HbCnzUeU5N1LaXLHfp1seO8qM6UBQ5KT0V7xg++tZU12hJTMt2lr2n259uDTx73WFlon+FKKhZqzejwcIqKKdAAp0UVAF0op0qkAKacZGeXWkKOlQDovToB2ya5JxvJWEp/wAOR/IV0fbHhIt8d1J4KQPpXKWnLslraLZ7q8sJj6kt7bZdPBPpAAQoE9PvEf6hXQOlLwmGowpitxsq9RSvwHuPhVRxBNVuZ7NFnbeKlhbohW1XZndF39zVuhiz9puI3ZsBwAolp4Z4H1VZwMpPPAPOuftpF/vOo9VOStYtPw7gykNCEtpTaGkjklIPFI69fOu68gjIOawLtZ7beGg3dYEWYgcg+0lePLI4VnRv3GPJUWV9zXKim8o/PfslSZKS5JYTvEDeJwlI8schV4aYv+iNKwcW2bGNwdQBIkpbV6xxx3QRwGelXdJ2S6GkrKnNOQwT+TeR9DXkjY/oRByNPRj/AIlrP1Nar5W17BQm5JdljX1NlCU6DcoxTfnkp1/aRpxGSZjjhPPdbUc1Vusr1a7tfmpdgjGNIKsrfdUlKVq7yDwHnXTW0WyaG0Bo6Zdk6dtYkgdnFQtkKLjp9kce7iT4A1ypBgrfjPyFsodecJVu8AMn6Vv4Twu2ot1aPN21f6IwurypJcksHQ+zW7PuWtDN51JaLjNcx2bMV1BWgY5HB9Y+7hWl1FHTbNs9oluLU1Gu8Yx1LScfeo5D34QPfVV6Qv0/RYelRbJAelnnJkkqKE9yQFDH1rY6svl7utrtOpb3OisuplJcgwGUhJCQclzBJVjIA41SS4HWoX05ppQqJx6LLa6Jdnh69tTrhfRnRS/5Raf07tnRs1H9XLiVLQ40CtC0KwUnB4/M0Tp7qruwlc7caUlvebWr1FA8wRyyelYiZKrrZGX4isCQ2lfAjik4yASDjh4VgIuDVznNIioe3lMJW6jtEboKSBuq9UnIJ6EV423hKKal0z7HoJQUsM20DAbdRudkEuKAaznsxngPhVaaHYFw2wajnNqWpi3spipUpRUST4nn7Kqn90mfZNon3GapOUIU6vd5AAcAPcKobS9/vNg09M1HZpkOUuRKUq4QXUbxbyfVXwIVgknw4irfhVrUr0rh03rLEVnbLeX9lhZ7nFfVY05U1LZZf0/+lp7Uru8i2uM2XU9ot8tvIdjPuI7RfhxJ3T4Y99UjofUttsNydk3S3qlS1KP9ZQsK3c88J5e/Ne2rb1cdZOMS5Nmt7EkAH0iPvJLie5WVHP1rEhvyNNXe3XmKw0Vx1BS2VAKQsclJPeCCR769nwngv4aydCstZb7J/Vbr1KG5v+av8SHT+bPb2LKRtS0+r2hLR5tf815XvaRpO82tUC8QpM9gEKR6m6pCh1Bzwq/9OW7SGrLBBvMOyWtxiW2FjeiN7yT1SeHMHIPlW3j6T09HUFMWK1oUOoio/lVb/pthCeeWSa/7jq/FVpLGmH5f5OHItolaivD39GrNcJmV5baYaJDSegO7nGO8kVcWz7YLdJ0tiXrVbcOA2rtPs9kgrcPcojgkd/M9OFdMtNIabCGkJQgckpGAPdX3VnO/eOWmsfdnL8LO55RWGosZqPHbQ0w0gIbbQMJSkDAAHcBVdbS5TbouCVEdkxEWF/wqJ+VTC/3xq3NKbaUFyiOCRx3fE1R21+7rt2j5CN4qnXZRispHFS847QgeRx/mrjpRdWoordnR/twc2UxqEEbNNIhfMvzVI/w7zY+oNQ01MNpDqY0y2WFsjcssNMZzHIvKJcdP8St3/LUOr0Unl5KcKdKnUAdFFFQBdKVPpSqQOnXzT6VAJhpWYzdrO5pe4SEMFTvpFtkuHCWJGMFBPRK8AeBANXds51UNSMGz3YiLqqEOydYdODKCeG8n9/hxHXmOZrn3Q+n3tU6utNkjEhc2QloqxncTnKle5IJ91TfbXdolw2ozWrQ03Dj2pKYjMhgbq/uU4K1EczkEA8+ArXXpQrQ5Z/U30KkoTzE6JgXufbT2QXvITw7N0Zx+orcs6wP99EHmldc96T20PsttRdawTdIyAEi4xSA+kdCocl+/B86s61aj0jfkA2bUcMOK5MzD2K/L1qpatnWpdMruizjWpT+bRlgI1fDPtsPp8sH9ayG9UW1ftLcb/wASD+maiC7POS2HEM9q2eS2lBYPvFYS21tq3XG1IV3KGK5nJrc2qnCWxVf7TmqGr5qu2WWG9vxITXau8wO0Xx+SQP4qruHcYTDSULkISsniOJxWPfUuX/W13fKylsyF7yv3QcAfACtgzZ4Dbe76OhXiria9dbU1TpRj5FBWkpTbPO8tuS7duxAHCsjiDwxWomWmSsdpMeU47uhKTzCQOQ8q3UeGbe8PRypUVw4UgnO4e8eFZ5APjW7TOTXzNLCPGw7QNSadiIjtojSI7aQkdok5CRwHIj5ipi3rzVqdNm+t6djJt5V6zyFY/wAxHPHjUMdhMuZynGe6sMwJhji3+nOi0Bfbej7xxv8AlVPd8Fta0lONOOW9cp6rrs1qWVDilamnGU3tpt+qMnUGutRamhuRnuxYiOjCkoB9YeZJ+VaKNapSApcF1TaigoXk4CgRgjyNSJmGy2BhAOO+vfgOVWFC1oW0Ph0YJI4q11Vry56kss11oC4lrbTMw2W8glR6Z4V4zbhAlR1sh9BV0BBHzr2fhm4SCZW8IzZwhsHG+epNfb9oguNbhjoT3FIwa6DSWh+zNrVNsi3bTk4OOBtXpMbdxwB4LHHx3T7zV2uavQP7OIo/4l1yFoMOWHaHawlRU1IWWQe8KGMfHFdLpt8kt9o432LX53iG0/E15zidNwrZj1Lmz5ZU/F0N27q+Uf7KO0nzJNa2Xf7jJBSqQUJP4Wxu/wDNaWffdKWcE3nU0BBHNuMvtlf6c1CrvtiiqkGJs+sL02UfVE2anOD3pQPqSPKuWFrWqa4wu70RvdWlF4jqybXyfB07aXbtqKT6PHSMttZ++kK/KhP6ngKq/Rpm7Q9Y3W9KdjNXmFBcfsVrcypO8ger4cM5GeauPIVANoydRMXxEjWbrkm6SGw6kLUChCc8gBwGO4cKxdIalk6Y1hZtSMEqXHeSXU5xvgcFp96T86tbOlSpxUoNSz1W3scNzUlPSWmOhGZTjzsl1clS1PqWS4V+0VZ458c151ZG37TrVj2hSZMAA2q8NpuUNQ5FDnEj3K3vdiq3rsOIVMUqKA+qKVOoAjyoo6UCpAqYooqAXB+zoEWqbqjV76ApvT9rcdRnkXlgpQn34UKqxx915uVJfUVvSXPXUeajneV88VbdoZVaP2Yrm82MSL9eEs73LLTYBwfAFKvjVcWW0y7upuJamO1cbypx9XBtvPNWT4AfDhRrPobaVNzeh76MuMPT096bcYInPlktx4qhkFSvxK8MZ4eNeT1qlXOYuSuNGgoWc9m0nAT5JqaWXQtwS0FQIyVOK5zJh3AfFKfax54zWxc2b3xYKnLw2D+Vlr+ZFYxlb0pupzeJ/wA2O5WV7VgoQg+UhMC1zravftt4lxHfzsKU2f8ASa9rnqLW0dg9rqO7SGB+L0txWPic1tbnou7wEOOJuoIQCpQeQUcB45NQn7afUgoe9ZJ54NdUJU62q1OKvbXFq0qixk9bQ8+YM9TJKpK1A7xPE55n60RrjNtslIlLW60rmFHPwNYduk9hcAWhltw7pSe41Z+ynQMTV1yvlzvpUbTbEnfSFlAOBkkkcQABnhzJFbW1FanPjLNQ06h9pLjSgpChkEV8uoWpP3a9xQ5HGR7xWsdcTZ7iOyiT41inZdgOTE4Km843gcYIz3Vt85GRxqDBrBrHJ8mN/wCTCcUB+Nk7w+HSvE6iiZxuPZ7t0fzrbNupWtaUn1kHCh3cM18rkNIktsrUA6sEpHlUgwmrhJk8I0NaUn8bx3R8OtZzKFpT94vfWeZxge4V9OOJbKAo4KjujxNfVCBKISCpRwAMk1E7hcpFxllmG4ptocsKwVeNbaU5Ju08W22Q5c7dBckNxEFSyhPFWMA4wOuKmWu9D2U7MrRrfSDDzETfDb6HHCo53tw72eSgsY7iDmoyk9TOMepWtxcfRbIvpClekIcJSrPrY78/Cvu22Z+4APy3VhB5EnKj8eVeF9dP2mA4MoQBhPzrHduT6huoO4jurIa40JIdPQSnH3me/eryFlkwl9rapzrLg4gZxn3it1o7RLeoIDUtcuQ9vD1ktkJCD1BPH9KmbGyyAEf+XKZV3tuE/WuOpd0otxkW9vwe7nFVIYXuVxq7Uk+/WyHD1EwkXCIT2MwcO0SeaVdOgOf51FUIUGX2ljBACx7v+DV1TtnEptpSGprVxjnmzJRuL9yx191QzUGhrnY2VSmo7ku37pCkc3WAQQc45jxHCuekreEeShhLsTWsbvLlWjr33/IkWrXf6U/s+aaux9eZp+Yu1vq69moBSD5Y3B51Thq5djzLV22fbRtOLeQrt4CZ0dCjhXaskqAA554DlVM1v2KtprRhTooFCB0uNOioAulKmaVSBiiinUAtHXdkRbtluz+Sq6TP+pMyHPRHF5YbKVj1gByzv8edZei9ocSzsM2272xqG0AAH4yPVV4qHXzFfe2jhs22UpHsi2Pn3lSKq2S+tuQ4jgps4yhQyOQ+FYzUZrklsd1reTt5c8d/5/NDqW2Xi3XJkOwZbLyD+VVZ++gDJUMedUpE2byl2G1Xax3VUZ+Wwl4tqJSASM4Chxx7qRtu0SL92lTchI5Ky2r64NUyq2lRtQrLTvpt6nqIcUmkviU37akl2qzbjcof2PZIS3g5gvSN5KUgflBJ+NVe5pRu1t9tqC4MxxjPYMnfcV4Cpe3prXt0wiXNbhtHnhQSf9A/Wsx/Qtp0vaJN3vjrtwfZTvJS5wQpf4RjrxxzrojxS2t0qUKik30jq2/XYrLpfiqjquD/APZ4SXotSsmPR5t5a9CjdhGbxhJOVEDqo95NXxsmeDuznaXZo5/r7kMy20j2lI3ClWPIp/1CqZ08yVvOSnQAt0leB4mtzarvcdKajYvVqkdk+1nCljebUk+024Pymr5xzHB5uU8zbI7qDV92v9hsVouTra4dmaUzFCUYUEqxnePXglI8hWHbbzIhpDZAda6JVzHka+tSLiSbrIlQIrMKO6orEZt7tEtk8SEnGd3uB5V6abt3pLyn3chpHAeJrIh4weDt2eVcDJipLalJCVJ5hVJTEySoyXVq7bOU5OD/AMVupjLLThQwVlQ5pbRvK+PIVr1x1b3GI8T3rfANSRkxjcpaZrL8tJWWuASRujzr1nX6RIbKGkhlJ5kHJNZsVtKVgSUSWkf/AJRvD+IfrX3frWhUQPRRko44HHIoRlZMfRmrrvo64SZtjdbbkSI64yy42F+orGcZ68Ac1cNomJj/ALKb0Scr7263fs4iVc1AOIUojwG4uqFhtoddT2q0BAI3gpW6SPA4qeXy9ydSC2RUBpi3Wxj0eJGjE9lHT+JRUeK3Fcye+sJRy0Zt4I7fsw7nHmBtDqRwKFjKVY6HzFZUa22K+nMOYbZLPOO/xRn9093hWXfIofhbo5p5E1vND2Wy6ytC4U9gsXeCNwusndUtHQkcjjl8K5L+5ja0/jSzhbtdPbsdlj/cbptJ+T/R9DZ7PLZetLTVjtokm1SCC4lLigUn8w4c/CrSFwiEZ7dA8ziqof2V3KMom1351tPQKCk/NJ/SvEbNr88rdnahJb64W4v6kVSVOIWNZ87rL6M9HbXVS1h8OFJ4/wDJFhXzWtitDalSZyFuDk22N5RqrtTbSbndm1tWpP2bCPBTyj94odwPT3cfGpnpTZhZI1wZVce0uC85IdOEE+Q5++qR1EAm/XFCeCESXEISOSQFEACtvD7u0uakoUcyccataa9l+5y8Qv7nkXN4U+i/V/sWf+zpFgy9py4UyMiS4uFILbjucpcCcggcuWe+qjltdhKfa/ItSfgcVa/7OJI26WcDkpEgHy9HXVY34YvdxA5CS5/9jVsnzLLPPTllmBRRTqTABTooqALpSp0qkBTpUxQFxbWU+kbGtlUtPEIjy2FHuIUjH0NVNO4yVEdQk/IVbdzxd/2X7Q8ni5Z704ys9wWkn/cmqnfO4qK962FISfVOD6pKefQ+rWD3RktmdHaCeMzZtp94D+zbWyrw3VlP6VuASOIrV6E1L/SrRPbrY7JyI8GCntCs4CRhRJ4knNbMV8uuYyjXqKaw+Z6eryerpNOnFp50R6pcWOS1D31We3Kc79mW2Hvq3HnitQJ54HD61ZaAn8RPuqt9uMEvWaFNYQrdjOkLOc4CscfiBXdwJwXEKXN3++NDXeJu3ljsQy1pCHHkD8OAPIVsK0FunJUtDwPBY3VjuNbG5SgyyQk8SM57hX1NnkDUXVLUueiFCaaQonLriUjNb+KwiOwhpoYQkYFYGj9G33UCXJsJaYsZZKe3dON7vwOZqUu7MtRR0b0W8x3l/lWFD6g1oncUovlctTvp8NuqsOeEG0aF6J2+Q665ufkQd0fKvEWaABxjJPiSa2NzsuqrEwHrvY33opGRKijtEY8SnOPfitP9vxB7aXkq7iitsZKSzF5OOdOcHyyWGZLVtZYOYynWfBKjj4HhWagEJAVx8cVj2sXa+vBjT1lnTnT+INkIT4k8gPMit4jZxqx9ZTOnRIShzQhW9u+HD+dYTqwh87wbqFpWuHinFsg05hNouSX+yS5DdOFJUkHdPhUkaU2tpKmiCgjhisq9bLtQNQ1mPcGpwAyWiSlRx3ZqL2GS4ykx3wUqQotqSrgUkGphVhVXgeSbm0rW2FVjg29xOIi/dRs+krg7RYYbUUiS2ULweeUZ+orDu0hO8loqASnis91Z2yuOq667TN3CY8RBWfDgUpHz+VcnFHGNnVc9uV/kTYpuvHHcvVTqzzWo++vJSieZJr0X2Z9neT58a8lV8lietZmWgH01Kz7CQST3cK5KnumTcJDx5uuqX8TmurlXBNns9zuik7wix1ObpVgKIGQPeRXM99u69TaoXcJDZaMhxJUguFYQOuCenhXqf6XUlOrLHh0WfNZePuVPFcOMI51LE/Ztb3ttDT/SJFlOnww2U/7qqa6udtc5bgOQt5avio1bn7PjghJ17qR3CUwbK9hR/OvkPMlNUya9jFYSRSN5eQpUUVkQMU6VOoAqKKVSB06QozUAt/Yzv3/Quv8ASI9d6RCTcYaO91k5IHiobo91VSCVwAD/AHTnyUP+PnUt2NamRpPaRZbm+rdidsGJJ7ml+qo+7OfdXptR06NK7SL3Z1J3YrjpXHPTs1+s2R4DIHuNRLbJlHfBI/2frmkT7rZXVY9La7VoE81p5jzwc+6rU5HHUVzHpu6O2LUEG4sg9pGeCikcyORHvGRXUk0JUtqS0CGZKA6nIxzGf1rwv9RW3wrpVVtNfdf4wX3DavPR5HvH8meANfMuCzOhvRpqUqjupKVpV1Br6Bxyr6BzVBlxeYvDLHTqc86w0vO0lcFLQFPW5xX3T2OBH5VdxrVelemoQw2SHnFJbAPicV03IiMSYym5rSHGFjBbWMhXuqndeaSt+mp9rutv32465iErZUd5KOO9wPPoa99wf+olc4t668fR9H+zKO74aoP4kNvyJ3rmS9pLQITZF9iqP2bDa90EgZwTg8Mn9ajGg9qLkqYzA1J2QLh3US0p3RvdAsDgPMY/Wp5ri1fbOmJkNJwpScpPcRxBrmSSw9FkrYfQpDyFbpSeYNWlpTp16bjLf7lpxS4r2VeE6T8OMY6aHYsOdJiA+ivrQlXEgcQfdWDLjR5kjt5MaO49+dTSc/StVot2Q7pa1qnAiT2CQvPPI4fpW8qteYtxyeghCFRKo46vyMoXKYmOI6HyhkDASgBIx7qg+v8AWkbSkRA3Q/cHhlpnOOH5ldw+tS6uZdqDklzW1yVL3vbw3n8g4DFdNpRVapieyK7ilw7KhmisNvHoT/ZdrO8ah1VKZubyVxzHU4htDYSlshSRw69TzJrQbWYrNr1k4+gbjcxlLygkfjHA/HGfOt5sOsb0YSbpIQUdsjcbBH4eeff+lfW0a2s3/aNZbW8taEKjqLhRzA9Y/pXS61OhXlNaRinn2KurSqVeGxdXWTlpnzKwgxZ+orgiHb2VOLUeXQDvUegroDRmmI2m7MiNHUlyQr1n3MYK1eHgOlZ9isVvs8AR7VHSyB7XVS/EnmTWYa8VxnjsuIf2qfhgvq/UWdjG2XNLVnyvhwNfNfSlE8Dxr6jtF55DaeajVDsss7dyJbYrmm17PjGCsSLk8GwnruJ4qPlwA99UBFylDzn5UED38PoTU926Xc3DWRgoCkx7c2GUAjA3jxUR8h7qhcaI9LXCt0RsuS5jqQlCeJUpR3UJ+Z+NfQOB23wLKOd56v3/AMYPO39X4ld42jp/Pcs6E2rTf7NlwkL9STqi5oZb7ywyck/xpUPI1T9XB+0PNYgTdP6KgLCo+nIKGXinkqQsBS/lu+8mqfq8OAKMUGioAU6VOgF0pU6VSBiigUGoA6ujW27tA2O2fVMfLl606E225gcVFnP3bh8OPPvKu6qWqwtimsI+ltULj3dPa6fuzRg3Bo8uzXwC8eGfgTQEM9IcZdZnRlbjueKsA7qx1GfjV27INXO6igP2W7SS7c2cux3HD6ziOqc94+h8KrfaPpJ7Q2r5dokntLe997EkDilxlXFCwe8cj76jVtmy7Hd2ZcRZalxlhST4/qD9KrOJcPhe0XTfzLZ/zp0Z2W1zKhNT6dUdRkEEgjBHA19IITxIyegrD0/e4urLG3d4GEOj1ZLAOS0vr7qyQa+dThKEnCaw1uj0ikmlKOzPsqKlZUck1GNqFoVdNFSg2CX2SH20gcTu8/kTUmRjOVch86+lq3yd7j0xWdtXlb1oVY/8WmROKqRcX1I7s11I3etPRUuuAy2khpzJ4lQH68620rStmlTkTH4LKpKOS90ZFVTr6zPaKmt3mxSOxjy3dxUYj1QrBPDw+lZJ1nrNhoMqsUku44LDTiknywOPxr6FSSuoK4t5eGXt6ozpcRpxj8K5jmUfLOezLlbQhpCUIASlIwAOlJT7STguIB7ioVRUhO0a+n1o01ls/hKQyB/EQa+U6E1ysbyn3EnuMw5+tbPwkV800jY+Kzf+3Rk16F9AhQykgjvFam6actV0eQ7PhNPrQcgrSDg1TiNPbQ7WrtI5kuEfkfSv5E1mMau11DWGJlnlvL5D+rOJUfeBg/Cn4SS1pzT9yf8AVIPw16Ul6rKLhdci2qFyQ00kcEjhVZ6DWvVO0O73xX/jx2+wYJ6kkAY9wUfeKjV0uOpL9e4VluqTbBOUEbpSd7dPfk593Crd07ZYmn7Y3BgJKUJ4qUfaWrqTVTxiurO3dLOZzX0XX9jmrXX4yaUFiEX16s2PLwNfTi9/ifa7++k6rf8AWPtdf51514lLOpszgOta7WWoG9I6VkTyoC4SAWoaDzKj+LyHP4d9bZHYMR35s91LMKOkrdcUcDArnPaLqt7Vt/XJwW4TX3cZr8qO8+J5/LpVrwjh7v6/iXgjq/29+vkcd5c/h6enzPb9zWTLpOvstDl2lOSCgZU4sAqCevH9KsrYNAjxrrdtfXtrFo06yXW8jg5IIw22nvIyPIlNVra7ZMudwiWW2Ml64zXEt7g55J4J8AOZ/wCKs/bTc4ultPWvZpYnErat+JF1kI5PylAcPJP8h0r6HThGK8Kwuh5ycm99yqL7dJF7vM25zVb0mW8p5w+KjmsCiithgKinRQBTooqALpSp9KMVIFToxRUAKdI0CgLv0TIi7VtEDRV4fQ3qi1oU7Y5bigC8gc46iefDl4AH8JzUcyHIYkvW64MuMXCKotltwYUCOaCO/urDhSpEGYzLhvLYksrC23EHCkqHEEGrxmR4e3DT5uEEsxdolvaxIjDCU3JtI9tP74/45YwaySngqfReqJ+k7ymZBO8g+q+ws4S6nuP6HpXTxZal25m4wxlp9CXAhJCgMjPMcxXKUqO76Q5GmNLYuDKihaHBukkcwQeSvrW3sWt9QWK6CSxOeVggLjunLagBjdKeQ4csYxXnuMcHd81Uo4U1v59l/ksbK8VuuWesX9jommnnWo0lq6z6xYT6K4iFdcevDcON496D1Hz8K3TzLjKt1xJSfGvE1ac6M3TqrEl0ZewnGceaDyiNbRbEvUmn1xY2PSGlBxneOASM8PDOTUIsO0yXYmBbr5BdL8cbhyOPD4Yq2RVO6s08L/tYNrD4jrlsBbbhTkBSWyRkd3q16b+nryPLO3r/ACRTlnttk5bmdWg1VovEnheptZe2JaxuwLUpSu9R/lmtaradqVRyi3AJ/wACv5VorpZtQ6TfUi529zsk8A+2N5tQ78jh8cGsROpmd31mV5r2NCja1YqdLEk+uclZW4rfKWJSx7Ewi7W7mwofaFsynvGR+grOe2xxlMHs4DyXCOHL+dQFu5Trsv0e1wX31K4brbZUflWbf9CXO0aWcvl9UmM6txDbMUcVcequg4Dl8a1Vo2dKcYTaUpPCWdX7G2lxW/cW08pdcEp0Pb7lqLVaNUXRpTMVnjGQr8R6EeAyTnvq03CCslPI8a0+k0dlpm1NnmmMj6CtukFSt1IJJ6CvnnFbuV1cOUtFHReiLSjDljq8t6v1PnpWbbofpSiV5Q2niVdK194uFr07CMy/yksIxlDI4uOeAH/vuqjtd7SbnqVRjRCq32pJ9VhpWFL7isjn5cqwseGV+IP+3pH/AKnt7dzG4uqduvFq+xtdt2q5E28OWCKW27bDVhSW173ar71eXd0qt2UiOgPLH3iv7JP+4/pXu8tanTLuKlPSF4ISs5UvhzV4fM1a+g9K27SlnTr7aKg7gO/arS5wXNc/Cop6IHA+7PLAPv7K1jbUI0YbLfzfU89XqupUdSXX7GZpaMzsi0MdWXdCf6ZXhot2iK6MqjNkcX1JPXiOfgOpqkJUh6XJdkSXVuvuqK3HFnKlKJyST31udcaquWstRyrxeHN5944S2n2GkDkhI6AD+daGuw5woFHWg0AUUUUA6KKKAVGaKVSB0UUVAHSop0AVlWq4zLTcY8+2yHI0yOsONOtnCkqFYlFAXwH9P7b4SG5bkaybRUJCEOn1Y9ywOAPcv5+Y4CptS2O5acuzlp1PDehzGhwUpPEjoR0UnxH6YrQpJSoKSSCOII6Vb2nNqsO8WtvT+1SAq92pA3WJ6OEuKe8K/EPn58qNZJTwVQpt6KpDzayMHKHW1dfA9DVo2HbBKg263xLrGN0CQr0h1xWHPaO7g9SB38++va67IZciA7edml0a1PZVZKmWiBJaHPccbPMjyye6qtktJbeWxLYdhSm1FK0KQQAe4pPFJ/8AcVx3djRu0o148yX89TfRrzovNN4OkbHq3S1+CfQboiK+rkxLw2c93Hh8CaiO0qNL01rKx6qSz2sVgpbdKD4n6pUapj0N1QJYAfHP7o5Pw5/KvZi7T48VUQSn/Q1e1HUsls/5eVVNtwKNtW+JSnmLTTi+z31/dHbLiDqQ5akcPo139Dri1ahtl2eaYiPJcU9GTLbBHBbZJTkeRGCOlZv2BaJJecetcBxxKd7eXHQTzA5keNcj2e7yrJcoNztzy92M4VIQVezn2kHwI+NdcaSvMW/2H7SgrCmX4+cdUq3k5SfEHhXmOL8FnwucZ0pNwlnXz7P+dyztrtXCcZrxLH0FKcgWW3PSXQzEiMJK1lKQlKR5Cqb2vagb1Uuy6esbbj0qQtEhxJHsbyfVSfHBye6sTbprBdxnJ03bF7zDKsySk+250R5Dr4+VVS5MebdWWHnO2XntHkqIKs9M91XPAOAunGF9Wfj1aT+zf5/Q5b6+Tbox+Xr5+SOl5twsOl4bTN5u0dtxltKOxbO8vgMeyOPyqF3DbNDYuDbNltqkwc4ckvH7w+KUju58T7hVLIivKSFqTuIP43Dug+Wefur7SiO2fXKn1dEo9UZ8Tz+A99dtH+nbWLcqzdRv2X0X6s5qnEqr+RKKPW4zp98uDkmdIdlyV8VLcVnA+gHyohR1uSmY0Flcye6oJbQ2gr9Y8gkfiP8A7xqf6S2Ual1Fb/tG4hjTunAA4ubPPZN7v5gkkFXgTw8akEjXekdnENcLZhENwvak9m7f5qM47+yQeWfh516CMElypYS6Fa5a56npaNIWXZjAb1FtNCJ1+cHbQLAle8on8K3u4Z6cRw6nhVXa71hdtbX1y6Xt/fcI3Wmk8G2UdEpHQfWtRdrlMu9xfn3SS7KmPq3nHnVbylHzrFrYYBRRRUAXWnSooAooooB0UUUAqVM0qkDoFFFQB0qKMUACiiigCnRSoDZWK93OwTkzLLPkQpKf7xhZST59486tKJtig36OiJtM0tAvwA3ftBhPYSgPEpwCfLFU2KKAuRvRWzXVLm9pTWq7LJVxEK+N7oSe4OjCT8Sa+bhsM14yguWn7PvkcDIXDmNryPJZHyzVPVlwbnOgLCoM2TGUORZdUj6GjSe5KbWxKpmhdb21a25mkbpukYUUQFFJH+JAxWbp7VN92fRLlbHIclr09nLCJDam1MuE43gCO7PvArWwdp2t4KQmNqq8BI5JVKUsfBRNY9717qS/SYsi9XJU5+Id6O480gls+Hq8fI8K11aFKtD4dSOY9jbSrSg85x5mTC0bq6SCqFpq8S3n/WW96E4scePMjHmalFq2J7RJqAt+2x7VHP8Aey5DTIHmkEqHwqMytqWupSd13VV3Ce5uQWx/pxUduF9u1yJNwuc2UTz7Z9S8/E1saT1ZhKbexar+zHSOnj2uutoMJTg9qJaUmS8T3Z47vmRivtO0vROkW9zZ/oxp6akYTcryrtXM/mCAeB8iBVLUUMCR6w1vqLWEkvahusiWM5S0Tuto8kDAHwqOUqM1IA0U6KgCFOlToBUUUUAU6KVAOiiipAjSp0UACilToAooNFQB0UqM0AZoFFOgFSp0UAUCiigCijpRQDpGiigCijpQKAKKKKAdFFFAFFFFAKig0UAUUGigHRRRUgVBooNQBU8UU6ARop0UAsUU6KAWKdLrToBUU6KAVHSnSoAoop0AUUUUAqKdFAIijFOigFToooAooooBYop0UAUUUUAUUCnUg//Z")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LULL>(&mut v2, 98000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

